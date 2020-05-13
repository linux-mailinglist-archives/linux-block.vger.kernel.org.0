Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C931D22B1
	for <lists+linux-block@lfdr.de>; Thu, 14 May 2020 01:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbgEMXFD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 May 2020 19:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731815AbgEMXFD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 19:05:03 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2332A20693;
        Wed, 13 May 2020 23:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589411102;
        bh=MFOJdxtS3/IHpGHNwAsHtxdCXiGJ3XzgovPrUtXJWWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6Z5m73PLAC/1EjuSrPHG0cnziR0COEQ+x8h7DZpq9EyP5mGBqka5pDwAXOpFoqCQ
         wlVCetyg2N3VlBtjekqyGKBGoRxs5P7irKPvtqgJSURov8fIEhX2fegbNrawE/BQAx
         uu9MmecrNrpKLhYHhhFmrq4RNdg4/Dxhh3xiMYt8=
Date:   Thu, 14 May 2020 08:04:55 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Tony Asleson <tasleson@redhat.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH v2 7/7] nvme: Add durable name for dev_printk
Message-ID: <20200513230455.GA1503@redsun51.ssa.fujisawa.hgst.com>
References: <20200513213621.470411-1-tasleson@redhat.com>
 <20200513213621.470411-8-tasleson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513213621.470411-8-tasleson@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 04:36:21PM -0500, Tony Asleson wrote:
> +static int dev_to_nvme_durable_name(const struct device *dev, char *buf, size_t len)
> +{
> +	char serial[128];
> +	ssize_t serial_len = wwid_show((struct device *)dev, NULL, serial);

wwid_show() can generate a serial larger than 128 bytes.

> +
> +	if (serial_len > 0 && serial_len < len) {
> +		serial_len -= 1;  // Remove the '\n' from the string

Comments in this driver should use the /* */ style.

> +		strncpy(buf, serial, serial_len);
> +		return serial_len;
> +	}
> +	return 0;
> +}
