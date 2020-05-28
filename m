Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C351E692F
	for <lists+linux-block@lfdr.de>; Thu, 28 May 2020 20:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405769AbgE1SSN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 28 May 2020 14:18:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405735AbgE1SSK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 14:18:10 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 830372073B;
        Thu, 28 May 2020 18:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590689890;
        bh=AI6mftzqfL5PqUmgUmNnymIfEoSbNgy5qQglt19o9yk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vdJgTUdMWvo0k/8NfoBN38tUzqyyhsugmhAR4HGCIcVmcuqc4A5Difa48syV37mh8
         dv63NaSZ0H51K05wj0Zd8jRXL6rGQO0gTRkCHK9tCZVglOS5wiNC3VipyzgnBpB4kN
         rf7/2AuEtGfXiD4p/Wi1qZ/AkE3WnhXu8dJtagpE=
Date:   Thu, 28 May 2020 11:18:07 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCHv2 1/2] blk-mq: export __blk_mq_complete_request
Message-ID: <20200528181807.GA3504306@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200528151931.3501506-1-kbusch@kernel.org>
 <20200528164256.GA25651@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528164256.GA25651@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 28, 2020 at 06:42:56PM +0200, Christoph Hellwig wrote:
> I think this needs a better name.

blk_mq_do_complete_req()?
