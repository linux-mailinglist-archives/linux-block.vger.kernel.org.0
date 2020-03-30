Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD95E197D90
	for <lists+linux-block@lfdr.de>; Mon, 30 Mar 2020 15:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgC3Nx0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 30 Mar 2020 09:53:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgC3Nx0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Mar 2020 09:53:26 -0400
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53AFA206CC;
        Mon, 30 Mar 2020 13:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585576405;
        bh=9fj94aO+4iZ5CJVZaUxcTEXkFO9lNUuFcHzpzx0huIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vUJuqJD9rP+HVMcF2vqQ/l2b7bWGsDibN/cJ6LOXo70nGdl2Sv2L3HajIyzdCENtf
         UBeBcJxxwtOxqAmQFfarvAsuPG6VLuLcMaNZRSZjOrU0BffsCnKwbsfYUWxGcgK4Ld
         poJII5poqzXZhxe3nQoK0eTu9BIUcPCC0yvN0cyc=
Date:   Mon, 30 Mar 2020 07:53:23 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Tokunori Ikegami <ikegami.t@gmail.com>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting
 value
Message-ID: <20200330135323.GA32604@C02WT3WMHTD6>
References: <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
 <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
 <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com>
 <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
 <20200327181825.GA8356@redsun51.ssa.fujisawa.hgst.com>
 <CACVXFVM=rT=86JrmAkySTg=gknfFL8Q1NU0uXWzoDMKMyL_mow@mail.gmail.com>
 <a0e7a985-a726-8e16-d29c-eb38a919e18e@gmail.com>
 <CACVXFVMsPstD2ZLnozC8-RsaJ7EMZK9+d47Q+1Z0coFOw3vMhg@mail.gmail.com>
 <cc1534d1-34f6-ffdb-27bd-73590ab30437@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc1534d1-34f6-ffdb-27bd-73590ab30437@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 30, 2020 at 06:15:41PM +0900, Tokunori Ikegami wrote:
> But there is a case that the command data length is limited by 512KB.
> I am not sure about this condition so needed more investigation.

Your memory is too fragmented. You need more physically contiguous
memory or you'll hit the segment limit before you hit the length
limit. Try allocating huge pages.
