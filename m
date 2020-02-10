Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACB7158459
	for <lists+linux-block@lfdr.de>; Mon, 10 Feb 2020 21:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBJUnQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 10 Feb 2020 15:43:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgBJUnQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Feb 2020 15:43:16 -0500
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B81214DB;
        Mon, 10 Feb 2020 20:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581367395;
        bh=KwCHrWA0wev45KvANN3aYLit9yFcWT8lnBqLoNfSfto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fka3jkqKrIkS/psSk5OgilmAPgjyLDfVTYwfRIQHQT3TyEoMXHlEFQ64fhkC/1+hb
         cjtrxqEWWbNkjWg+w0dXmwniLwJ7anlBdzRaZN27CFODTA/ZjtWfczVjkYt2vnS4VV
         YD1/rdBYN8xbNKNRpg1bZF7kuRkjp59Gj2SSKe7A=
Date:   Mon, 10 Feb 2020 12:43:13 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Tim Walker <tim.t.walker@seagate.com>
Cc:     linux-block@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
Message-ID: <20200210204313.GA3736@dhcp-10-100-145-180.wdl.wdc.com>
References: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 10, 2020 at 02:20:10PM -0500, Tim Walker wrote:
> -What Linux storage stack assumptions do we need to be aware of as we
> develop these devices with drastically different performance
> characteristics than traditional NAND? For example, what schedular or
> device driver level changes will be needed to integrate NVMe HDDs?

Right now the nvme driver unconditionally sets QUEUE_FLAG_NONROT
(non-rational, i.e. ssd), on all nvme namespace's request_queue flags. We
need the specification to define a capability bit or field associated
with the namespace to tell the driver otherwise, then we can propogate
that information up to the block layer.

Even without that, an otherwise spec compliant HDD should function as an
nvme device with existing software, but I would be interested to hear
additional ideas or feature gaps with other protocols that should be
considered in order to make an nvme hdd work well.
